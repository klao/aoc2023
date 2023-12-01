const std = @import("std");

const digits = "0123456789";

fn part1() !void {
    var file = try std.fs.cwd().openFile("i01.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var buf: [1024]u8 = undefined;
    var sum: u64 = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        // std.debug.print("line: {}\n", .{line.len});
        const f = std.mem.indexOfAny(u8, line, digits).?;
        const l = std.mem.lastIndexOfAny(u8, line, digits).?;
        const val = 10 * (line[f] - '0') + (line[l] - '0');
        sum += val;
    }
    std.debug.print("part1: {}\n", .{sum});
}

pub fn main() !void {
    try part1();
}
