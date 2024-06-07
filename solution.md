# Example solutions for Higgs Challenge exercise

Fit a BDT with HistGradientBoostingClassifier in default settings

```python
from sklearn.ensemble import HistGradientBoostingClassifier

models = {}

models["hist_bdt_default"] = HistGradientBoostingClassifier().fit(
    X_train, y_train, sample_weight=weight_for_fit,
)
```

To evaluate, adjust the code in section *Evaluate performance*

* define `key = "hist_bdt_default"` and adjust later to try for different models
* replace `model.score` by `models[key].score` and `model.predict_proba` by `models[key].predict_proba`

To fit a BDT with more trees, set `max_iter=1000` in the HistGradientBoostingClassifier constructor, e.g.

```python
models["hist_bdt_1000"] = HistGradientBoostingClassifier(max_iter=1000, random_state=42).fit(
    X_train, y_train, sample_weight=weight_for_fit
)
```

Plot progression of training (building of trees) and amount of overfitting with

```python
for i, key in enumerate(["hist_bdt_default", "hist_bdt_1000"]):
    plt.plot(-models[key].train_score_, color=f"C{i}", alpha=0.5)
    plt.plot(-models[key].validation_score_, color=f"C{i}")
```

To fit a standard `GradientBoostingClassifier` to use for feature importances use

```python
models["bdt_default_sub001"] = GradientBoostingClassifier(subsample=0.01, verbose=True).fit(
    X_train, y_train, sample_weight=weight_for_fit
)
```

You can then plot the feature importances with

```python
pd.Series(
    models["bdt_default_sub001"].feature_importances_,
    index=feature_names
).sort_values().plot(kind="barh")
```

To get a list of feature names, sorted by importance, highest first you can do

```python
argsort = np.argsort(models["bdt_default_sub001"].feature_importances_)
np.array(feature_names)[argsort[::-1]].tolist()
```

Select a set of features from this list and replace `feature_names` by this to try training on a different number of features. You will then of course need to reexecute all cells that depend on this.
