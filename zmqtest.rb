require 'rubygems'
require 'zmq'

@context = nil
@socket = nil

def init_zmq
  @context = ZMQ::Context.new
end

def get_started
  case ARGV[0]
  when "c"
    start_client
  when "s"
    start_server
  else
    puts "usage: zmqtest <s|c>"
  end
end

def start_server
  puts "Starting server"
  init_zmq
  socket = @context.socket(ZMQ::REP)
  socket.bind("tcp://127.0.0.1:5000")

  while true
    msg = socket.recv
    puts "MSG: #{msg}"
    puts socket.send(msg)
  end
end

def start_client
  puts "client"
  init_zmq
  socket = @context.socket(ZMQ::REQ)
  socket.connect("tcp://127.0.0.1:5000")
  #socket.connect("tcp://127.0.0.1:6000")
  1.upto(10).each do |i|
    msg = "msg #{i}"
    socket.send(msg)
    puts "Sending: #{msg}"
    msg_in = socket.recv
  end
end

get_started
