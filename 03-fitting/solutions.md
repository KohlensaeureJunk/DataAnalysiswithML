# Exercise 1: 

```python
plt.plot(x, y, "ok")
```

# Exercise 2:

```python
f(x) - y
```

# Exercise 3:

```python
coeffs = np.polyfit(x_exercise3, y_exercise3, deg=1)
print(coeffs)
g = np.poly1d(coeffs)

# Some points where we evaluate our new function
x_new = np.linspace(x[0], x[-1], 50)
y_new = g(x_new)

# Plot the datapoints
plt.plot(x, y, 'ko', label="data")

# Plot our fitted polynomial
plt.plot(x_new, y_new, 'r-', label="fit")

# Add legend etc
plt.legend()
plt.xlim([x[0]-1, x[-1] + 1 ])
plt.show()
```

# Exercise 4a

Simply replace the function definition with

```python
def gaus(x, norm, mean):
    # Note that this function takes a whole vector x of data!
    return norm * np.exp(-(x-mean)**2/(2**2))
```

Alternative 1: use `lambda x, norm, mean: gaus(x, norm, mean, sigma=1)` as the function

Alternative 2: `from functools import partial` and use `partial(gaus, sigma=1)` as the function

# Exercise 4b

```python
def mymodel(x, b, norm, mean, sigma):
    return x + b + gaus(x, norm, mean, sigma)
```

Remember to substitute ``mymodel`` for the gaussians above.

# Exercise 4c

```
b2 = a1 * c + b1 - a2 * c
```

So

```python
def line(x, a1, b1, a2, c):
    return np.where(x<c, a1 * x + b1, a2 * x +a1 * c + b1 - a2 * c)
```

# Exercise 5

```python
def f_quadratic(x, a, b, c):
    return a*x**2 + b*x + c
    
pfit_q, pcov_q = curve_fit(f_quadratic, x_data, y_data, sigma=yerr_data, absolute_sigma=True)

chi2_pvalue(
    f_chi2(f_quadratic, pfit_q, x_data, y_data, yerr_data),
    len(x_data) - len(pfit_q)
)
```

# Exercise 6

```python
def toy_chi2():
    y_fit = f_quadratic(x_data, *pfit_q)
    y_toy = np.random.normal(loc=y_fit, scale=yerr_data)
    pfit_toy, _ = curve_fit(f_quadratic, x_data, y_toy, sigma=yerr_data, absolute_sigma=True)
    return f_chi2(f_quadratic, pfit_toy, x_data, y_toy, yerr_data)


def plot():
    plt.hist([toy_chi2() for _ in range(10000)], bins=100, range=(0, 30), density=True)
    x = np.linspace(0, 30, 100)
    plt.plot(x, scipy.stats.chi2.pdf(x, len(x_data) - len(pfit_q)))

plot()
```

# Exercise 7

Our null hypothesis is $\mu=0$.

# Exercise 8

```python
def scan(z_target, start, exp=5, stop=100):
    for n in range(start, stop):
        p = 1 - stats.poisson.cdf(n, exp)
        z = pvalue_to_significance(p)
        if z >= z_target:
            print(f"{z:.2f} sigma for {n} events")
            return n

n = 5
n = scan(3, n)
n = scan(5, n)
```

# Exercise 9

```python
for n in range(10):
    p = stats.poisson.cdf(0, n)
    if p < 0.05:
        print(f"p-value = {p:.3g} for {n} events")
        break
```

This is one incarnation of the famous "rule of three" in statistics.

# Exercise 10

```python
pvalue = (toys >= q0_obs).mean()
```

# Exercise 11

```python
pvalue_asymptotic = significance_to_pvalue(np.sqrt(q0_obs))

plt.hist(toys, bins=20, density=True);
x = np.linspace(0, 15, 100)
plt.plot(x, 0.5*stats.chi2.pdf(x, 1))
plt.yscale("log")
```

Actually not that bad given that this is the "large sample limit" approximation
