import gleam/dynamic/decode
import gleam/http/request
import gleam/httpc
import gleam/json
import gleam/option.{type Option, None, Some}
import gleam/result

pub type Agent {
  Agent(service: Option(String))
}

pub type Repo {
  Repo(
    did: String,
    head: String,
    rev: String,
    active: Bool,
    status: Option(String),
  )
}

fn repo_decoder() -> decode.Decoder(Repo) {
  use did <- decode.field("did", decode.string)
  use head <- decode.field("head", decode.string)
  use rev <- decode.field("rev", decode.string)
  use active <- decode.field("active", decode.bool)
  use status <- decode.optional_field(
    Some("status"),
    None,
    decode.optional(decode.string),
  )
  decode.success(Repo(did:, head:, rev:, active:, status:))
}

pub type ComAtprotoSyncListRepos {
  ComAtprotoSyncListRepos(cursor: String, repos: List(Repo))
}

fn list_repos_decoder() -> decode.Decoder(ComAtprotoSyncListRepos) {
  use cursor <- decode.field("cursor", decode.string)
  use repos <- decode.field("repos", decode.list(repo_decoder()))
  decode.success(ComAtprotoSyncListRepos(cursor:, repos:))
}

fn list_repos_from_json(
  json_string: String,
) -> Result(ComAtprotoSyncListRepos, json.DecodeError) {
  json.parse(from: json_string, using: list_repos_decoder())
}

pub fn new_client() -> Agent {
  Agent(None)
}

pub fn with_session(agent: Agent, service: String) -> Agent {
  Agent(..agent, service: Some(service))
}

// pub fn login(agent: Agent, identifier: String, password: String) -> Agent {
//   todo
//   // TODO: actually implement the login
// }
//
// pub fn post(agent: Agent, post_text: String) -> Agent {
//   todo
// }

pub fn list_records(agent: Agent) -> Result(ComAtprotoSyncListRepos, String) {
  let base_url = option.unwrap(agent.service, "bsky.app")
  let assert Ok(base_req) =
    request.to("https://" <> base_url <> "/xrpc/com.atproto.sync.listRepos")
  let req = request.prepend_header(base_req, "accept", "application/json")

  // TODO: actual error types
  use res <- result.try(
    httpc.send(req) |> result.map_error(fn(_) { "HTTP request failed" }),
  )
  use json <- result.try(
    list_repos_from_json(res.body)
    |> result.map_error(fn(_) { "JSON parsing failed" }),
  )

  Ok(json)
}
