# ci-cd-standards-using-opa
[![Actions Status](https://github.com/ameydev/ci-cd-standards-using-opa/workflows/Build./badge.svg?branch=master)](https://github.com/ameydev/ci-cd-standards-using-opa/actions) [![Actions Status](https://github.com/ameydev/ci-cd-standards-using-opa/workflows/Opa%20tests/badge.svg?branch=master)](https://github.com/ameydev/ci-cd-standards-using-opa/actions)

A github-action to validate your infrastructure configuration manifests (eg. kubernetes resource yaml manifests) following the CI-CD standards set using OpenPolicyAgent(OPA).


## Usage

## Example workflow.

```yaml
name: Pre-deploy validation of k8s resources.
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: OPA-Test ci-cd manifests standards.
      uses: ameydev/ci-cd-standards-using-opa@master
      env:
        MANIFESTS_PATH_PATTERN: k8s/subpath/ #eg. directoy path or file path k8s/subpath/deploy.yaml
        LIBRARY_PATH: opa-policies/ci-standards #path to your ci-cd policies.
        DATA: data.kubernetes.admission.deny # the policy data 
```
