# CR BUILD Action IBMCloud

This action is to build an image into IBM Cloud

## Entradas

### `tag`

**Mandatory** tag number


## Ejemplo de uso


```yaml
# File: .github/workflows/workflow.yml
on: [push]

name: example

jobs:

  devflow:
    runs-on: ubuntu-latest
    steps:
    
    - uses: mnevadom/helm-tag@v1
      with:
        tag: 1.4.2

```
