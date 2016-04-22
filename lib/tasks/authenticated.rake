task authenticated: :environment do
    $redis.FLUSHALL
    def parse_cookie response
        all_cookies = response.get_fields('set-cookie')
        cookies_array = Array.new
        all_cookies.each { | cookie |
            cookies_array.push(cookie.split('; ')[0])
        }
        cookies_array.join('; ')
    end
    puts "[START] Login"
    response = HTTParty.post("http://localhost:3000/api/v1/users/sign_in.json", body: {
        user: {
            email: "user0@example.com",
            password: "001100"
        }
    })
    new_cookie = parse_cookie response
    puts response.parsed_response.to_json
    puts "[END] Login\n\n"
    (0..Settings.access_limit.authenticated+1).each do |i|
        puts "[START] request #{i}"
        response = HTTParty.get("http://localhost:3000/api/v1/users/profile.json", headers: {"Cookie" => new_cookie}).parsed_response
        puts response.to_json
        puts "[END] request #{i}"
    end
end
