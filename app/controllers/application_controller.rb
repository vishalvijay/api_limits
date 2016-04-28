class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    respond_to :json, :html
    skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

    before_action :control_api_access, :if => Proc.new { |c| c.request.format == 'application/json' }

    protected

    def base_respond result, status = :ok
        obj = {result: result}
        obj[:api_access_limit_details] = api_access_limit_details if @limit
        render(json: obj, status: status)
    end

    def api_access_limit_details
        {unblock_after: @unblock_after, remaining_access: (@limit - @current_access_count)}
    end

    private

    def control_api_access
        key, @limit = get_access_key_and_limit
        obj_str = $redis.hget :api_access_map, key
        obj = if obj_str
            JSON.parse obj_str
        else
            {
                "current_access_count" => 0,
                "unblock_after" => next_time_to_block
            }
        end
        unblock_after = DateTime.parse obj["unblock_after"]
        current_access_count = obj["current_access_count"].to_i
        if unblock_after < DateTime.now
            unblock_after = next_time_to_block
            current_access_count = 0
            update_access_details key, unblock_after, current_access_count
        elsif current_access_count + 1 > @limit
            update_access_details key, unblock_after.iso8601, current_access_count
            render(json: {message: "Api access limit exceeded. Please try after #{unblock_after}"}, status: :forbidden) and return false
        else
            update_access_details key, unblock_after.iso8601, current_access_count
        end
    end

    def update_access_details key, unblock_after, current_access_count
        @unblock_after = unblock_after
        @current_access_count = current_access_count+1
        $redis.hmset :api_access_map, key, {unblock_after: @unblock_after, current_access_count: @current_access_count}.to_json
    end

    def get_access_key_and_limit
        if current_user
            ["user-#{current_user.id}", Settings.access_limit.authenticated]
        else
            [request.remote_ip, Settings.access_limit.unauthenticated]
        end
    end

    def next_time_to_block
        (DateTime.now + Settings.access_blocking_duration.minutes).iso8601
    end
end
