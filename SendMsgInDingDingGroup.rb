require 'uri'
require 'net/http'
require 'digest/md5'
require 'time'
require 'json'

timestamp = (Time.now.to_i * 1000).round.to_i / 1000

params = { "chatid" => 'chat35649e97aa7f8d38b8ae7e9ef7cec5bc',
           "sender" => 'luxianyou',
           "msgtype" => 'text',
           "text" => { "content" => 'test' }
		}
 
headers = { "appId" => "a41ecd63332746ac",
            "timestamp" => timestamp.to_s,
            "signature" => Digest::MD5.hexdigest( "a41ecd63332746ac" + "a3f5bdb1c04c4e1071e7d5b85382fcc8" + timestamp.to_s),
            "Content-Type" => "application/json"
           }
url = URI.parse("http://ddcorp.luxianyou.cn/chat/send")
req = Net::HTTP::Post.new(url.path, headers)
req.body = params.to_json
puts params.to_json
res = Net::HTTP.new(url.host,url.port).start{|http| http.request(req)}
puts "Response #{res.code} #{res.message}: #{res.body}" 