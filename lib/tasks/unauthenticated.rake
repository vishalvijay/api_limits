task unauthenticated: :environment do
    $redis.FLUSHALL
    (0..Settings.access_limit.unauthenticated+1).each do |i|
        puts "[START] request #{i}"
        response = HTTParty.get("http://localhost:3000/api/v1/repositories/2.json").parsed_response
        puts response.to_json
        puts "[END] request #{i}"
    end
end
