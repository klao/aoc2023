const std = @import("std");

const input_file = "in/i02.txt";

const Bag = struct {
    red: u32 = 0,
    green: u32 = 0,
    blue: u32 = 0,
};

const Line = struct {
    num: u32,
    bag: Bag,
};

fn parseLine(
    line: []const u8,
) !Line {
    var bag = Bag{};

    var parts = std.mem.splitScalar(u8, line, ':');
    const numStr = parts.next().?;
    var num: u32 = try std.fmt.parseUnsigned(u32, numStr[5..], 10);

    const bagStr = parts.next().?;
    std.debug.assert(parts.next() == null);

    var elems = std.mem.splitAny(u8, bagStr, " ,;");
    var val: u32 = 0;
    while (elems.next()) |elem| {
        if (elem.len == 0) {
            continue;
        }
        if (elem.len < 3) {
            val = try std.fmt.parseUnsigned(u32, elem, 10);
            continue;
        }
        switch (elem[0]) {
            'r' => bag.red = @max(bag.red, val),
            'g' => bag.green = @max(bag.green, val),
            'b' => bag.blue = @max(bag.blue, val),
            else => unreachable,
        }
    }

    return Line{ .num = num, .bag = bag };
}

pub fn main() !void {
    var file = try std.fs.cwd().openFile(input_file, .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var buf: [1024]u8 = undefined;
    var part1: u32 = 0;
    var part2: u32 = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var l = try parseLine(line);
        // std.debug.print("line: {}\n", .{l});
        if (l.bag.red <= 12 and l.bag.green <= 13 and l.bag.blue <= 14) {
            part1 += l.num;
        }
        part2 += l.bag.red * l.bag.green * l.bag.blue;
    }

    std.debug.print("part1: {}\n", .{part1});
    std.debug.print("part2: {}\n", .{part2});
}
