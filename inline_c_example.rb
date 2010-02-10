require 'rubygems'
require "inline"
class MyTest
	inline do |builder|
		builder.include "<stdio.h>"
		builder.include "<curl/curl.h>"
		builder.include "<curl/easy.h>"
		builder.add_compile_flags "-I/usr/include/curl"
		builder.add_link_flags "-lcurl"

		builder.c <<-"END"
			long factorial(int max) {
			int i=max, result=1;
			while (i >= 2) { result *= i--; }
			return result;
		}
		END

		builder.c '
			void hello(void) {
			printf("hello\n");
		}'

		builder.c <<-"END"
			int curltest(void) {
				CURL *curl;
				CURLcode res;
				curl = curl_easy_init();
				if(curl) {
					curl_easy_setopt(curl, CURLOPT_URL, "curl.haxx.se");
					res = curl_easy_perform(curl);
					curl_easy_cleanup(curl);
				}
				return 0;
			}
		END
	end
end

t = MyTest.new()
t.hello
#t.curltest

t.hello

sleep 10


