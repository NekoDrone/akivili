# Akivili

[![Package Version](https://img.shields.io/hexpm/v/akivili)](https://hex.pm/packages/akivili)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/akivili/)

Akivili is an ATProto client SDK written in Gleam!

## Specs

Currently the project exists as a simple HTTP wrapper for the ATProto API. More features to bring it up to parity with the rest of the official TypeScript and Golang SDKs are coming soon!

| Specs          | Status |
| -------------- | ------ |
| `http_client`  | ⏳     |
| `identifiers`  | ❌     |
| `bsky`         | ❌     |
| `crypto`       | ❌     |
| `mst`          | ❌     |
| `lexicon`      | ❌     |
| `identity`     | ❌     |
| `streaming`    | ❌     |
| `service_auth` | ❌     |
| `plc`          | ❌     |
| `oauth_server` | ❌     |

## Installation

```sh
gleam add akivili
```

## Usage

```gleam
import akivili

pub fn main() {
  // TODO: An example of the project in use
}
```

Further documentation can be found at <https://hexdocs.pm/akivili>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```

## Contributing

TBD

## License

MIT

#### Made with 💜 for [🗑️](https://honkai-star-rail.fandom.com/wiki/Trailblazer)``
