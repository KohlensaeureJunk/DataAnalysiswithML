# Exercise 1

## Masking

```python
out = []
for i in range(len(batch["x"])):
    x = batch["x"][i][~batch["mask"][i]][np.newaxis, :]
    out.append(model(x, mask=torch.zeros((1, x.shape[1]), dtype=bool)))
```

## Permutation invariance

```python
x_after = x[:, rnd]
mask_after = mask[:, rnd]
```

## Lorentz invariance

### Rotations

```python
c = phi.cos()
s = phi.sin()
rot = torch.tensor([[ 1,  0,  0,  0],
                    [ 0,  c, -s,  0],
                    [ 0,  s,  c,  0],
                    [ 0,  0,  0,  1]])
```

### Boosts

```python
g = gamma
b = beta * gamma
boost = torch.tensor([[ g, -b,  0,  0],
                      [-b,  g,  0,  0],
                      [ 0,  0,  1,  0],
                      [ 0,  0,  0,  1]])
```

# Exercise 2

## Add a Dropout layer

First, add the dropout layer in the `__init__` method of the `NanoPelican` class:

```python
def __init__(...):
    ...
    self.dropout = nn.Dropout(0.05)
```

And in the `forward` method:

```python
def forward(...):
    ...
    x = self.linear1(x).relu().masked_fill(mask, 0)
    x = self.dropout(x) # <- newly added
    ...
```

## Increase or reduce the number of parameters

Example for more parameters:

```python
def __init__(...):
    ...
    self.linear1 = nn.Linear(6, 16)
    self.linear2 = nn.Linear(32, 1)
```

Example for (even) fewer parameters:

```python
def __init__(...):
    ...
    self.linear1 = nn.Linear(6, 1)
    self.linear2 = nn.Linear(2, 1)
```
