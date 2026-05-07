# Install tree-sitter-cli
cargo install --locked tree-sitter-cli

# Install golangci-lint
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# Install gofumpt, stricter formatting
go install mvdan.cc/gofumpt@latest

# Installing go delve (debugger)
go install github.com/go-delve/delve/cmd/dlv@latest
