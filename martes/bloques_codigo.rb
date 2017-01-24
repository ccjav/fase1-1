def time
  yield
  sleep 1
  yield  
end

time { p Time.now}