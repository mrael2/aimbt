const std = @import("std");

pub fn main() !void {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var general_purpose_allocator: std.heap.GeneralPurposeAllocator(.{}) = .init;
    const gpa = general_purpose_allocator.allocator();
    const text = try stdin.readAllAlloc(gpa, 5_000_000);

    const parsed = try std.json.parseFromSlice(std.json.Value, gpa, text, .{});
    defer parsed.deinit();

    const hash_map = parsed.value.object;

    try stdout.print("count = {}\n", .{hash_map.count()});
    if (hash_map.get("Time Series (Daily)")) |value| {
        const dates_prices = value.object;
        try stdout.print("{}\n", .{dates_prices.count()});
    }
}
