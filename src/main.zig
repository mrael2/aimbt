const std = @import("std");

pub fn main() !void {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var general_purpose_allocator: std.heap.GeneralPurposeAllocator(.{}) = .init;
    const gpa = general_purpose_allocator.allocator();
    const text = try stdin.readAllAlloc(gpa, 5_000_000);

    _ = try std.json.parseFromSlice(std.json.Value, gpa, text, .{});

    try stdout.print("hello\n", .{});
}
