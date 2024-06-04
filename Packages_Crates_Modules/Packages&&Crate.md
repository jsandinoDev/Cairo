

## Crate

A crate is a subset of a package that is used in the actual Cairo compilation. This includes:

- The package source code, identified by the package name and the crate root, which is the main entry point of the package.
- A subset of the package metadata that identifies crate-level settings of the Cairo compiler, for example, the edition field in the Scarb.toml file.

Crates can contain modules, and the modules may be defined in other files that get compiled with the crate,



### What is the Crate Root?


The crate root is the lib.cairo source file that the Cairo compiler starts from and makes up the root module of your crate. \


### What is a package

A Cairo package is a directory (or equivalent) containing:

- A Scarb.toml manifest file with a [package] section.
- Associated source code.
This definition implies that a package might contain other packages, with a corresponding Scarb.toml file for each package.


```
my_package/
├── Scarb.toml
└── src
    └── lib.cairo

```


- src/ is the main directory where all the Cairo source files for the package will be stored.
- lib.cairo is the default root module of the crate, which is also the main entry point of the package.
- Scarb.toml is the package manifest file, which contains metadata and configuration options for the package, such as dependencies, package name, version, and authors. You can find documentation about it on the Scarb reference.