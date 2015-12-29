variable = { true, { variable = "temperature" , unit = "C" , value = 28 } }
json_text = cjson.encode(variable)

print(json_text)
