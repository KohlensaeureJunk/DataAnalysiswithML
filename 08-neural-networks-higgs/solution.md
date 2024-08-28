# Exercise hints Higgs Challenge NN exercise

To change number of neurons and/or add layers for MLPClassifier simply use option ```hidden_layer_sizes``` as shown below:

```python
from sklearn.neural_network import MLPClassifier
mlp = MLPClassifier(verbose=True, early_stopping=True, max_iter=40, hidden_layer_sizes=(100,100,100))
 # ...
)
```

And in case of keras just add layers using the dense function:

```python
from tensorflow.keras import regularizers

model = Sequential([
    Dense(units=100, activation="relu", input_shape=X_train.shape[1:], kernel_regularizer=regularizers.l2(0.0001)),
    Dense(units=100, activation="relu", kernel_regularizer=regularizers.l2(0.0001)),
    Dense(units=100, activation="relu", kernel_regularizer=regularizers.l2(0.0001)),
    Dense(units=1, activation="sigmoid")
])
```

