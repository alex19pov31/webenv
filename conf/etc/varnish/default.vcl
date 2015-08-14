 backend localhost {
     .host = "127.0.0.1";
     .port = "8780";
 }

sub vcl_recv {
    set req.http.x-host = req.http.host;
    set req.http.x-url = req.url;
    set req.http.host = regsub(req.http.host, "^www\.", "");
    set req.grace = 1h;
    set req.backend = localhost;

    if (req.http.Accept-Encoding) {
        if (req.http.Accept-Encoding ~ "gzip") {
          # If the browser supports it, we'll use gzip.
          set req.http.Accept-Encoding = "gzip";
        }
        else if (req.http.Accept-Encoding ~ "deflate") {
          # Next, try deflate if it is supported.
          set req.http.Accept-Encoding = "deflate";
        }
        else {
          # Unknown algorithm. Remove it and send unencoded.
          unset req.http.Accept-Encoding;
        }
    }

        if (req.request != "GET" &&
      req.request != "HEAD" &&
      req.request != "PUT" &&
      req.request != "POST" &&
      req.request != "TRACE" &&
      req.request != "OPTIONS" &&
      req.request != "DELETE") {
        return (pipe);
    }

    if (req.http.Authorization || req.http.Authenticate) {
        return (pass);
    }
    if (req.request != "GET" && req.request != "HEAD") {
        return (pass);
    } 
    if (req.http.Cookie) {
        set req.http.Cookie = regsuball(req.http.Cookie,
            "(^|; ) *__utm.=[^;]+;? *", "\1");
        if (req.http.Cookie == "") {
            remove req.http.Cookie;
        }
    }

    if (req.url ~ "^/bitrix/admin"){
        return (pass);
    }

    #unset req.http.Cookie;
    return (lookup);
}

sub vcl_fetch {

        set beresp.grace = 1h;
        if(req.url ~ "^/catalog" || req.url ~ "^/(?|$)") {
                set beresp.ttl = 3h;
        }
}