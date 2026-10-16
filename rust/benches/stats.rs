//! Criterion benchmarks. Run with `just bench`; ci runs them once in
//! `--test` mode so they can't silently rot.

use criterion::{BenchmarkId, Criterion, Throughput, criterion_group, criterion_main};
use rust_template::stats::{mean, variance};
use std::hint::black_box;

#[allow(clippy::cast_precision_loss)]
fn bench_stats(c: &mut Criterion) {
    let mut group = c.benchmark_group("stats");
    for len in [64_usize, 4096] {
        let xs: Vec<f64> = (0..len).map(|i| i as f64).collect();
        group.throughput(Throughput::Elements(len as u64));
        group.bench_with_input(BenchmarkId::new("mean", len), &xs, |b, xs| {
            b.iter(|| mean(black_box(xs)));
        });
        group.bench_with_input(BenchmarkId::new("variance", len), &xs, |b, xs| {
            b.iter(|| variance(black_box(xs)));
        });
    }
    group.finish();
}

criterion_group!(benches, bench_stats);
criterion_main!(benches);
