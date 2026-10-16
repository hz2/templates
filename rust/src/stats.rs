//! Basic descriptive statistics over `f64` slices.
//!
//! Every function returns [`None`] for an empty slice rather than
//! producing `NaN` from a division by zero.

/// Returns the arithmetic mean of `xs`,
///
/// $$ \bar{x} = \frac{1}{n} \sum_{i=1}^{n} x_i $$
///
/// or [`None`] if `xs` is empty.
///
/// # Examples
///
/// ```
/// use rust_template::stats::mean;
///
/// assert_eq!(mean(&[2.0, 4.0]), Some(3.0));
/// assert_eq!(mean(&[]), None);
/// ```
pub fn mean(xs: &[f64]) -> Option<f64> {
    if xs.is_empty() {
        return None;
    }
    #[allow(clippy::cast_precision_loss)]
    let n = xs.len() as f64;
    Some(xs.iter().sum::<f64>() / n)
}

/// Returns the population variance of `xs`,
///
/// $$ \sigma^2 = \frac{1}{n} \sum_{i=1}^{n} (x_i - \bar{x})^2 $$
///
/// or [`None`] if `xs` is empty.
///
/// # Examples
///
/// ```
/// use rust_template::stats::variance;
///
/// assert_eq!(variance(&[1.0, 3.0]), Some(1.0));
/// ```
pub fn variance(xs: &[f64]) -> Option<f64> {
    let m = mean(xs)?;
    #[allow(clippy::cast_precision_loss)]
    let n = xs.len() as f64;
    Some(xs.iter().map(|x| (x - m) * (x - m)).sum::<f64>() / n)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn mean_of_empty_is_none() {
        assert_eq!(mean(&[]), None);
    }

    #[test]
    fn mean_of_single_is_itself() {
        assert_eq!(mean(&[4.5]), Some(4.5));
    }

    #[test]
    fn variance_of_constant_is_zero() {
        assert_eq!(variance(&[7.0; 16]), Some(0.0));
    }

    #[test]
    fn variance_of_empty_is_none() {
        assert_eq!(variance(&[]), None);
    }
}
