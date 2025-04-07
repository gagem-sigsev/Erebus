const std = @import("std");

const Packet = @import("./packet.zig").Packet;
const Protocol = @import("./protocol.zig").Protocol;
const prompts = @import("./prompts.zig");

pub fn main() !void {
    const packet = try Packet.new("127.0.0.1", "127.0.0.1", "Hello World!");
    std.debug.print("\x1b[2J\x1b[H", .{}); // Clear the terminal buffer
    std.debug.print("\t\t\t\t{s}\n", .{prompts.welcome});
    std.debug.print("\n\t\t\t\t\t\t|PACKET|\n\t\t\t\t\t\tSrc: {s}\n\t\t\t\t\t\tDst: {s}\n\t\t\t\t\t\tPayload: {s}\n\t\t\t\t\t\tLength: {d}\n\t\t\t\t\t\tChecksum: {d}\n", .{
        packet.src,
        packet.dst,
        packet.payload,
        packet.data_length,
        packet.checksum,
    });

    const proto = Protocol.new();

    proto.send(packet) catch |err| {
        std.debug.print("Error: {any}\n", .{err});
    };
}
