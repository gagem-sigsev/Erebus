const PacketError = @import("./errors.zig").PacketError;

pub const Packet = struct {
    src: []const u8,
    dst: []const u8,
    data_length: u32,
    checksum: u16,
    payload: []const u8,

    const Self = @This();

    pub fn new(src: []const u8, dst: []const u8, payload: []const u8) !Packet {
        const checksum = try calculateChecksum(payload);
        const length: u32 = calculatePayloadLength(payload);
        return Packet{
            .src = src,
            .dst = dst,
            .data_length = length,
            .checksum = checksum,
            .payload = payload,
        };
    }

    fn calculatePayloadLength(payload: []const u8) u32 {
        var length: u32 = 0;
        for (payload) |p| {
            _ = p;
            length += 1;
        }

        return length;
    }

    fn calculateChecksum(payload: []const u8) PacketError!u16 {
        var sum: u16 = 0;
        for (payload) |*byte| {
            sum += byte.*;
        }
        // Return custom error on overflow
        if (sum > 65535) {
            return PacketError.CheckSumOverflow;
        }

        return sum;
    }
};
