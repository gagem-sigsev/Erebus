const std = @import("std");

const Packet = @import("./packet.zig").Packet;
const Errors = @import("./errors.zig");

pub const Protocol = struct {
    const Self = @This();

    pub fn new() Self {
        return Protocol{};
    }

    pub fn send(self: *const Self, pkt: Packet) !void {
        _ = self;
        const src = try std.net.Address.parseIp(pkt.src, 4444);
        const dst = try std.net.Address.parseIp(pkt.dst, 4444);
        std.debug.print("\n\n\t\t\t\t\t\t|PROTOCOL|\n\t\t\t\t\t\tSrc: {any}\n\t\t\t\t\t\tDst: {any}\n\t\t\t\t\t\tChecksum: {b}\n\n\n\n\n", .{ src, dst, pkt.checksum });

        const stream = std.net.tcpConnectToAddress(dst) catch |err| {
            return err;
        };

        stream.writeAll(pkt.payload) catch |err| {
            std.debug.print("Error: {any}\n", .{err});
        };
    }
};
