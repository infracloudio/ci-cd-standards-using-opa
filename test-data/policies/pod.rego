package kubernetes.admission

# restrict latest tag
deny[msg] {
  input.kind = "Pod"
  container := input.spec.containers[_]
  endswith(container.image,":latest")
  msg = "Pod Standards: Containers must not use latest tags"
}