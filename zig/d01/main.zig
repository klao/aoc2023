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
        const f = std.mem.indexOfAny(u8, line, digits).?;
        const l = std.mem.lastIndexOfAny(u8, line, digits).?;
        const val = 10 * (line[f] - '0') + (line[l] - '0');
        sum += val;
    }
    std.debug.print("part1: {}\n", .{sum});
}

const word_digits = [_][]const u8{ "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };

fn first_digit(line: []const u8) u8 {
    var pos = std.mem.indexOfAny(u8, line, digits).?;
    var digit = line[pos] - '0';
    for (word_digits, 1..) |word, i| {
        const p = std.mem.indexOf(u8, line, word);
        if (p == null) continue;
        if (p.? >= pos) continue;
        pos = p.?;
        digit = @intCast(i);
    }
    return digit;
}

fn last_digit(line: []const u8) u8 {
    var pos = std.mem.lastIndexOfAny(u8, line, digits).?;
    var digit = line[pos] - '0';
    for (word_digits, 1..) |word, i| {
        const p = std.mem.lastIndexOf(u8, line, word);
        if (p == null) continue;
        if (p.? <= pos) continue;
        pos = p.?;
        digit = @intCast(i);
    }
    return digit;
}

fn part2() !void {
    var file = try std.fs.cwd().openFile("i01.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var buf: [1024]u8 = undefined;
    var sum: u64 = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        const f = first_digit(line);
        const l = last_digit(line);
        // std.debug.print("{} {}\n", .{ f, l });
        const val = 10 * f + l;
        sum += val;
    }
    std.debug.print("part2: {}\n", .{sum});
}

pub fn main() !void {
    try part1();
    try part2();
}
