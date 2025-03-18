# This file has been generated by node2nix 1.11.1. Do not edit!

{nodeEnv, fetchurl, fetchgit, nix-gitignore, stdenv, lib, globalBuildInputs ? []}:

let
  sources = {
    "@nomicfoundation/slang-0.16.0" = {
      name = "_at_nomicfoundation_slash_slang";
      packageName = "@nomicfoundation/slang";
      version = "0.16.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/slang/-/slang-0.16.0.tgz";
        sha512 = "JBI+X+6/1WnaVNvnWp7o9PRbIFpgxKDmEKzYnMUfrBGFmm7rT2PsvFvVBoZPeM09B0AFYK+XJt9tqnbJvzhlLw==";
      };
    };
    "@nomicfoundation/slang-darwin-arm64-0.16.0" = {
      name = "_at_nomicfoundation_slash_slang-darwin-arm64";
      packageName = "@nomicfoundation/slang-darwin-arm64";
      version = "0.16.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/slang-darwin-arm64/-/slang-darwin-arm64-0.16.0.tgz";
        sha512 = "tdrpV2/sEy9pWevl6pg2qdG8chV5R2lO80D0vgwP3FTd27vwLRgAdSMSUlhtVSb8NWKx6E1dagjjNfabUzmZpQ==";
      };
    };
    "@nomicfoundation/slang-darwin-x64-0.16.0" = {
      name = "_at_nomicfoundation_slash_slang-darwin-x64";
      packageName = "@nomicfoundation/slang-darwin-x64";
      version = "0.16.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/slang-darwin-x64/-/slang-darwin-x64-0.16.0.tgz";
        sha512 = "a4OsidbwzaKOR7693ImYUSRKnmOs1xvTJviln0bc9nr6fngSkzXF7ijlHL/9/FrBhCIR+jY2ozmncWNOmqrvjQ==";
      };
    };
    "@nomicfoundation/slang-linux-arm64-gnu-0.16.0" = {
      name = "_at_nomicfoundation_slash_slang-linux-arm64-gnu";
      packageName = "@nomicfoundation/slang-linux-arm64-gnu";
      version = "0.16.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/slang-linux-arm64-gnu/-/slang-linux-arm64-gnu-0.16.0.tgz";
        sha512 = "4kHqeVbJ6HvmhSIP3p/vS4SjiaC8/TRbeh+6jT77mr6fb6fVxUcVdNwCTVPocn7GRx1rYAsuYqjYZkeS72ubzg==";
      };
    };
    "@nomicfoundation/slang-linux-arm64-musl-0.16.0" = {
      name = "_at_nomicfoundation_slash_slang-linux-arm64-musl";
      packageName = "@nomicfoundation/slang-linux-arm64-musl";
      version = "0.16.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/slang-linux-arm64-musl/-/slang-linux-arm64-musl-0.16.0.tgz";
        sha512 = "seuEaQSEGa3yqBI6Y/HH4X10+f7BNkX5OzOTNjWejqSIFAVBj0mWNBNWetT2YWDHRqiOSm5khD3+8LaSvShDRQ==";
      };
    };
    "@nomicfoundation/slang-linux-x64-gnu-0.16.0" = {
      name = "_at_nomicfoundation_slash_slang-linux-x64-gnu";
      packageName = "@nomicfoundation/slang-linux-x64-gnu";
      version = "0.16.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/slang-linux-x64-gnu/-/slang-linux-x64-gnu-0.16.0.tgz";
        sha512 = "DI8sIWhz1EsuAE2L4vlBM48WaSaWpRgUixG1ZHIlxpTwzn6s+DxmfAxmOcBeLpNdtfba9eSpqF+2539zllktPQ==";
      };
    };
    "@nomicfoundation/slang-linux-x64-musl-0.16.0" = {
      name = "_at_nomicfoundation_slash_slang-linux-x64-musl";
      packageName = "@nomicfoundation/slang-linux-x64-musl";
      version = "0.16.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/slang-linux-x64-musl/-/slang-linux-x64-musl-0.16.0.tgz";
        sha512 = "80obGwJ336r5wxQ/dLzEDp1nlAYtMWdnP5G5T2JmCnIkxxEVnyQIH62VcK6mc7RMSVeAlL1RGGx2LdNbk9V4QA==";
      };
    };
    "@nomicfoundation/slang-win32-arm64-msvc-0.16.0" = {
      name = "_at_nomicfoundation_slash_slang-win32-arm64-msvc";
      packageName = "@nomicfoundation/slang-win32-arm64-msvc";
      version = "0.16.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/slang-win32-arm64-msvc/-/slang-win32-arm64-msvc-0.16.0.tgz";
        sha512 = "hcmsfXjRaCuy5/eUhrdDOnE5uqfJ0vVXvon5mTHaWzf6UE4REIx3vJwf/t4QQu1Q4mKKO5ZxzauBdzRtbhOKsw==";
      };
    };
    "@nomicfoundation/slang-win32-ia32-msvc-0.16.0" = {
      name = "_at_nomicfoundation_slash_slang-win32-ia32-msvc";
      packageName = "@nomicfoundation/slang-win32-ia32-msvc";
      version = "0.16.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/slang-win32-ia32-msvc/-/slang-win32-ia32-msvc-0.16.0.tgz";
        sha512 = "W9959+Tdq71kkE5EGxoQWBxhpe9bjxpY7ozDoPjz2lBzaGi8X24z4toS6us3W83URIf6Cve0VizAX4fz5MWjFw==";
      };
    };
    "@nomicfoundation/slang-win32-x64-msvc-0.16.0" = {
      name = "_at_nomicfoundation_slash_slang-win32-x64-msvc";
      packageName = "@nomicfoundation/slang-win32-x64-msvc";
      version = "0.16.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/slang-win32-x64-msvc/-/slang-win32-x64-msvc-0.16.0.tgz";
        sha512 = "sOKuMtm3g62ugdhgpWqjF+o3clIR4eAIiAbx6oRPGB/9fPukgZnI5untsgTYJyVldAzby7jlIQ4R7df18aNraw==";
      };
    };
    "@nomicfoundation/solidity-analyzer-0.1.1" = {
      name = "_at_nomicfoundation_slash_solidity-analyzer";
      packageName = "@nomicfoundation/solidity-analyzer";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/solidity-analyzer/-/solidity-analyzer-0.1.1.tgz";
        sha512 = "1LMtXj1puAxyFusBgUIy5pZk3073cNXYnXUpuNKFghHbIit/xZgbk0AokpUADbNm3gyD6bFWl3LRFh3dhVdREg==";
      };
    };
    "@nomicfoundation/solidity-analyzer-darwin-arm64-0.1.1" = {
      name = "_at_nomicfoundation_slash_solidity-analyzer-darwin-arm64";
      packageName = "@nomicfoundation/solidity-analyzer-darwin-arm64";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/solidity-analyzer-darwin-arm64/-/solidity-analyzer-darwin-arm64-0.1.1.tgz";
        sha512 = "KcTodaQw8ivDZyF+D76FokN/HdpgGpfjc/gFCImdLUyqB6eSWVaZPazMbeAjmfhx3R0zm/NYVzxwAokFKgrc0w==";
      };
    };
    "@nomicfoundation/solidity-analyzer-darwin-x64-0.1.1" = {
      name = "_at_nomicfoundation_slash_solidity-analyzer-darwin-x64";
      packageName = "@nomicfoundation/solidity-analyzer-darwin-x64";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/solidity-analyzer-darwin-x64/-/solidity-analyzer-darwin-x64-0.1.1.tgz";
        sha512 = "XhQG4BaJE6cIbjAVtzGOGbK3sn1BO9W29uhk9J8y8fZF1DYz0Doj8QDMfpMu+A6TjPDs61lbsmeYodIDnfveSA==";
      };
    };
    "@nomicfoundation/solidity-analyzer-freebsd-x64-0.1.1" = {
      name = "_at_nomicfoundation_slash_solidity-analyzer-freebsd-x64";
      packageName = "@nomicfoundation/solidity-analyzer-freebsd-x64";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/solidity-analyzer-freebsd-x64/-/solidity-analyzer-freebsd-x64-0.1.1.tgz";
        sha512 = "GHF1VKRdHW3G8CndkwdaeLkVBi5A9u2jwtlS7SLhBc8b5U/GcoL39Q+1CSO3hYqePNP+eV5YI7Zgm0ea6kMHoA==";
      };
    };
    "@nomicfoundation/solidity-analyzer-linux-arm64-gnu-0.1.1" = {
      name = "_at_nomicfoundation_slash_solidity-analyzer-linux-arm64-gnu";
      packageName = "@nomicfoundation/solidity-analyzer-linux-arm64-gnu";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/solidity-analyzer-linux-arm64-gnu/-/solidity-analyzer-linux-arm64-gnu-0.1.1.tgz";
        sha512 = "g4Cv2fO37ZsUENQ2vwPnZc2zRenHyAxHcyBjKcjaSmmkKrFr64yvzeNO8S3GBFCo90rfochLs99wFVGT/0owpg==";
      };
    };
    "@nomicfoundation/solidity-analyzer-linux-arm64-musl-0.1.1" = {
      name = "_at_nomicfoundation_slash_solidity-analyzer-linux-arm64-musl";
      packageName = "@nomicfoundation/solidity-analyzer-linux-arm64-musl";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/solidity-analyzer-linux-arm64-musl/-/solidity-analyzer-linux-arm64-musl-0.1.1.tgz";
        sha512 = "WJ3CE5Oek25OGE3WwzK7oaopY8xMw9Lhb0mlYuJl/maZVo+WtP36XoQTb7bW/i8aAdHW5Z+BqrHMux23pvxG3w==";
      };
    };
    "@nomicfoundation/solidity-analyzer-linux-x64-gnu-0.1.1" = {
      name = "_at_nomicfoundation_slash_solidity-analyzer-linux-x64-gnu";
      packageName = "@nomicfoundation/solidity-analyzer-linux-x64-gnu";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/solidity-analyzer-linux-x64-gnu/-/solidity-analyzer-linux-x64-gnu-0.1.1.tgz";
        sha512 = "5WN7leSr5fkUBBjE4f3wKENUy9HQStu7HmWqbtknfXkkil+eNWiBV275IOlpXku7v3uLsXTOKpnnGHJYI2qsdA==";
      };
    };
    "@nomicfoundation/solidity-analyzer-linux-x64-musl-0.1.1" = {
      name = "_at_nomicfoundation_slash_solidity-analyzer-linux-x64-musl";
      packageName = "@nomicfoundation/solidity-analyzer-linux-x64-musl";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/solidity-analyzer-linux-x64-musl/-/solidity-analyzer-linux-x64-musl-0.1.1.tgz";
        sha512 = "KdYMkJOq0SYPQMmErv/63CwGwMm5XHenEna9X9aB8mQmhDBrYrlAOSsIPgFCUSL0hjxE3xHP65/EPXR/InD2+w==";
      };
    };
    "@nomicfoundation/solidity-analyzer-win32-arm64-msvc-0.1.1" = {
      name = "_at_nomicfoundation_slash_solidity-analyzer-win32-arm64-msvc";
      packageName = "@nomicfoundation/solidity-analyzer-win32-arm64-msvc";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/solidity-analyzer-win32-arm64-msvc/-/solidity-analyzer-win32-arm64-msvc-0.1.1.tgz";
        sha512 = "VFZASBfl4qiBYwW5xeY20exWhmv6ww9sWu/krWSesv3q5hA0o1JuzmPHR4LPN6SUZj5vcqci0O6JOL8BPw+APg==";
      };
    };
    "@nomicfoundation/solidity-analyzer-win32-ia32-msvc-0.1.1" = {
      name = "_at_nomicfoundation_slash_solidity-analyzer-win32-ia32-msvc";
      packageName = "@nomicfoundation/solidity-analyzer-win32-ia32-msvc";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/solidity-analyzer-win32-ia32-msvc/-/solidity-analyzer-win32-ia32-msvc-0.1.1.tgz";
        sha512 = "JnFkYuyCSA70j6Si6cS1A9Gh1aHTEb8kOTBApp/c7NRTFGNMH8eaInKlyuuiIbvYFhlXW4LicqyYuWNNq9hkpQ==";
      };
    };
    "@nomicfoundation/solidity-analyzer-win32-x64-msvc-0.1.1" = {
      name = "_at_nomicfoundation_slash_solidity-analyzer-win32-x64-msvc";
      packageName = "@nomicfoundation/solidity-analyzer-win32-x64-msvc";
      version = "0.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nomicfoundation/solidity-analyzer-win32-x64-msvc/-/solidity-analyzer-win32-x64-msvc-0.1.1.tgz";
        sha512 = "HrVJr6+WjIXGnw3Q9u6KQcbZCtk0caVWhCdFADySvRyUxJ8PnzlaP+MhwNE8oyT8OZ6ejHBRrrgjSqDCFXGirw==";
      };
    };
  };
in
{
  "@nomicfoundation/solidity-language-server" = nodeEnv.buildNodePackage {
    name = "_at_nomicfoundation_slash_solidity-language-server";
    packageName = "@nomicfoundation/solidity-language-server";
    version = "0.8.11";
    src = fetchurl {
      url = "https://registry.npmjs.org/@nomicfoundation/solidity-language-server/-/solidity-language-server-0.8.11.tgz";
      sha512 = "HdhQa5jOWkcnKFqEM8OBRHvbUHEeyCqZvj7qlGiISJTv4OS9ZInmKD30qe9oWunX4vx7d5kyMjKguWVsjemNxQ==";
    };
    dependencies = [
      sources."@nomicfoundation/slang-0.16.0"
      sources."@nomicfoundation/slang-darwin-arm64-0.16.0"
      sources."@nomicfoundation/slang-darwin-x64-0.16.0"
      sources."@nomicfoundation/slang-linux-arm64-gnu-0.16.0"
      sources."@nomicfoundation/slang-linux-arm64-musl-0.16.0"
      sources."@nomicfoundation/slang-linux-x64-gnu-0.16.0"
      sources."@nomicfoundation/slang-linux-x64-musl-0.16.0"
      sources."@nomicfoundation/slang-win32-arm64-msvc-0.16.0"
      sources."@nomicfoundation/slang-win32-ia32-msvc-0.16.0"
      sources."@nomicfoundation/slang-win32-x64-msvc-0.16.0"
      sources."@nomicfoundation/solidity-analyzer-0.1.1"
      sources."@nomicfoundation/solidity-analyzer-darwin-arm64-0.1.1"
      sources."@nomicfoundation/solidity-analyzer-darwin-x64-0.1.1"
      sources."@nomicfoundation/solidity-analyzer-freebsd-x64-0.1.1"
      sources."@nomicfoundation/solidity-analyzer-linux-arm64-gnu-0.1.1"
      sources."@nomicfoundation/solidity-analyzer-linux-arm64-musl-0.1.1"
      sources."@nomicfoundation/solidity-analyzer-linux-x64-gnu-0.1.1"
      sources."@nomicfoundation/solidity-analyzer-linux-x64-musl-0.1.1"
      sources."@nomicfoundation/solidity-analyzer-win32-arm64-msvc-0.1.1"
      sources."@nomicfoundation/solidity-analyzer-win32-ia32-msvc-0.1.1"
      sources."@nomicfoundation/solidity-analyzer-win32-x64-msvc-0.1.1"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "Solidity language server by Nomic Foundation";
      homepage = "https://github.com/NomicFoundation/hardhat-vscode#readme";
      license = "MIT";
    };
    production = true;
    bypassCache = true;
    reconstructLock = true;
  };
  "@tailwindcss/language-server" = nodeEnv.buildNodePackage {
    name = "_at_tailwindcss_slash_language-server";
    packageName = "@tailwindcss/language-server";
    version = "0.14.9";
    src = fetchurl {
      url = "https://registry.npmjs.org/@tailwindcss/language-server/-/language-server-0.14.9.tgz";
      sha512 = "t9tXYWWkLdfd3PrOZD+xF+B2a1tE5GI6VJu5dVw6wI5mSR3gmUPXEx4QF1vd7Ox7/tP+5a3faGhrp0BjCawPtw==";
    };
    buildInputs = globalBuildInputs;
    meta = {
      description = "Tailwind CSS Language Server";
      homepage = "https://github.com/tailwindlabs/tailwindcss-intellisense/tree/HEAD/packages/tailwindcss-language-server#readme";
      license = "MIT";
    };
    production = true;
    bypassCache = true;
    reconstructLock = true;
  };
}
