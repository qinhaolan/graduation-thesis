from sklearn.datasets import load_iris
import pandas as pd

iris_datasets = load_iris()
# 可以查看一下数据类型，
type(iris_datasets)
iris_datasets.keys()
print(iris_datasets['DESCR'][:50])
# In[6]:
type(iris_datasets.data)
type(iris_datasets.DESCR)
type(iris_datasets.target)
type(iris_datasets.target_names)
print(iris_datasets.feature_names)
data_np = pd.DataFrame(iris_datasets.data,
                       columns=['sepal length (cm)', 'sepal width (cm)', 'petal length (cm)', 'petal width (cm)'])
label = pd.DataFrame(iris_datasets.target, columns=['target'])
type(label)
data_np['target'] = label
data_np.head(5)
data_np.to_csv("iris.csv")
