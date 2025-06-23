use std::net::TcpListener;
use std::io::Write;

fn main() {
    let listener = TcpListener::bind("0.0.0.0:5000").unwrap();
    println!("rust app running on port 5000");
    for stream in listener.incoming() {
        let mut stream = stream.unwrap();
        let resp = "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nhi rust";
        stream.write_all(resp.as_bytes()).unwrap();
    }
}
