snzy is a connectionless network protocol based off of the User Datagram Protocol (UDP)

Step-by-Step Plan for SnzyProtocol
1. Protocol Design (High-Level Overview):

The first thing you need is a clear understanding of what your protocol will do. Here's what you should decide:

    Connectionless: This means the protocol doesn't establish a persistent connection between the sender and receiver before sending data. Each packet is independent, and there’s no need to manage state between communication parties.

    Packet Structure: Design how the data will be packed into a packet. You’ll likely have:

        Header: Contains metadata, such as source and destination address, length of data, checksum, and any other relevant control info.

        Data: The actual data being sent.

    Consider the following fields for your packet:

        Source Address: The address of the sender.

        Destination Address: The address of the receiver.

        Checksum: To ensure the integrity of the data.

        Data Length: How large the data part of the packet is.

        Payload: The actual data being transferred.

    Data Encoding: You will need to decide how to encode the data. For instance, is it plain text? Binary? Does it require any special handling (e.g., serialization)?

    Error Handling: Since you’re going connectionless, packets might get lost. How will you handle errors? Will you add features like:

        Packet Resending: Should the sender retransmit if no acknowledgment is received (maybe a simple timer)?

        Time-to-Live (TTL): To avoid infinitely circulating packets.

        Checksums: To verify packet integrity.

Start by clearly defining the packet format and the basic rules of communication for your protocol.
2. Define the Communication Model:

Now think about how the sender and receiver will interact:

    Sender:

        The sender will create and send packets to a destination without establishing a connection first.

        You might want to introduce a mechanism to control the sending rate (for congestion control or efficiency).

        Add a way to monitor packet delivery (e.g., through a timeout to track if a packet was lost).

    Receiver:

        The receiver will passively listen for incoming packets, receive them, and validate them (via checksums or other error-detection methods).

        It can process packets one by one and may handle them in a sequential or asynchronous manner.

        It might need to send an acknowledgment (though, you mentioned connectionless, so this could be optional or implicit).

You can keep this simple at first—just one sender and one receiver—but you should have a solid idea of how the data will flow.
3. Implementing the Low-Level Networking (Socket Programming):

Here, you will interface with your OS’s networking APIs. Both Zig and Rust provide socket libraries that will help you handle the communication.

    Rust: You'll use the std::net library for TCP/UDP sockets. Since you're aiming for a connectionless protocol, you'd likely be working with UDP sockets (UdpSocket).

    Zig: Zig has low-level access to networking, so you’ll interact directly with UDP packets, using std libraries or the raw socket API.

In this part, the main tasks are:

    Opening a socket for communication.

    Listening for incoming packets on a specified port.

    Sending packets to a specific destination.

4. Implementing Packet Sending and Receiving:

    Sending Data:

        Create a function to pack the data into your protocol's packet format (including the header and the payload).

        Use the socket to send the binary packet over the network.

    Receiving Data:

        Create a function to receive data from the socket.

        When you receive a packet, you should:

            Check the validity of the packet (checksum, address, etc.).

            Process the data (whether it’s a simple print or some other action).

            Send an acknowledgment or response (if you choose to implement that).

5. Error Detection & Handling:

Since you're working with a connectionless protocol, you need to consider error handling:

    Checksums: You can implement a simple checksum (like CRC32 or a simple XOR checksum) to ensure that the packet wasn’t corrupted in transit.

    Packet Loss: Given that you’re using UDP, packets can be dropped. A basic approach could be to implement retransmission on timeout—keep track of the packets sent, and if an acknowledgment isn't received within a set time, resend the packet.

    Timeouts: You could implement a timeout for each packet sent. If no response is received in a certain time window, the sender retries the packet.

6. Advanced Features (Optional):

    Packet Fragmentation: If you want to send large amounts of data, you could consider implementing fragmentation and reassembly. This involves splitting the data into smaller packets, each with its own header, and reassembling them at the receiver.

    Flow Control: You could add a simple mechanism to control the rate of data being sent to avoid overwhelming the receiver or the network.

7. Testing and Debugging:

    Unit Testing: Write unit tests for each component. For example:

        Does the packet creation correctly include the checksum?

        Is the packet received correctly with all fields intact?

    Simulate Packet Loss: You can simulate packet loss by using networking tools or by intentionally adding delays in the network layer.

    Edge Cases: Think about corner cases like what happens when packets arrive out of order, or with incorrect addresses.

8. Documentation:

Once you’ve got it working, document your protocol:

    Overview: What the protocol is, what it does, and how it works.

    Packet Format: Describe the structure of the packets, including headers, checksums, etc.

    Usage: How to use the protocol (e.g., send a packet, receive a packet, error handling).

This will be critical for your resume because you’ll be able to showcase your ability to document complex systems.
