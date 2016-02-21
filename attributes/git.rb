
release = 'v2.7.1.windows.2'
git_version = '2.7.1.2'

hash = '956417448441e267a0ca601f47a2cd346e2d09589673060ae25d66628b2abc82'

normal['git']['version'] = git_version

# DisplayName of Git in the registry, for idempotency
normal['git']['display_name'] = "Git version #{git_version}"

url = "https://github.com/git-for-windows/git/releases/download/#{release}"
exe = "Git-#{git_version}-64-bit.exe"

normal['git']['url'] = url
normal['git']['exe'] = exe
normal['git']['checksum'] = hash
normal['git']['home'] = 'C:\\Program Files\\Git'
