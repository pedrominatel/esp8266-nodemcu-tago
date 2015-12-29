counter = 0
ip = ""

function tagoReadData()

    print("Reading...")

    conn=net.createConnection(net.TCP, 0)
    conn:on("receive", function(conn, payload) print(payload) end)
    conn:dns("realtime.tago.io",function(conn,ip)

        print(ip)
        conn:on("receive",function(conn, payload)
            print(payload)
            conn:close()
        end)

    conn:on("disconnection", function(conn)end)

end)
-- fim function tagoReadData
end

function tagoSendData()

print("Sending...")

conn=net.createConnection(net.TCP, 0)
conn:on("receive", function(conn, payload) print(payload) end)
conn:dns("realtime.tago.io",function(conn,ip)

print(ip)

conn:connect(80, ip)
-- http post
conn:send("POST /data HTTP/1.1\r\n")
conn:send("Accept: */*\r\n")
conn:send("Accept-Encoding: gzip, deflate, compress\r\n")
conn:send("Content-Length: 36\r\n")
conn:send("Content-Type: application/x-www-form-urlencoded; charset=utf-8\r\n")
conn:send("Device-Token: 16cfae00-353b-11e5-b1c2-495a10b4464b\r\n")
conn:send("Host: api.tago.io\r\n")
conn:send("User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n")
conn:send("_ssl: false\r\n")
conn:send("\r\n")

conn:send("variable=temperature&unit=C&value=" ..counter.."&")

conn:on("receive",function(conn, payload)
    print(payload)
    counter = counter + 1
    conn:close()
end)

conn:on("disconnection", function(conn)end)

end)
-- fim function tagoSendData
end

-- timer para atualizar a lista de comandos a cada 5s
tmr.alarm(1, 5000, 1, function() tagoReadData() end )
--tmr.alarm(2, 60000, 1, function() tagoSendData() end )
