# Development

This document exists soley because I am incredibly clueless at how to build something as extensive as an ATProto SDK in a completely different language.

I would seriously super duper appreciate any pointers in the right direction if anyone happens to stumble upon this file and glimpse at my sheer skill issues.

## What is an SDK?

Idk what the actual definition of it is, but the way I see it is a simple and extensible way to kickstart development of various ATProto apps using Gleam.

This means that this project should be able to run on both of Gleam's runtimes, JS in browser and Erlang in BEAM.

Unless there is a case where we need to split the implementation for one reason or another. In which case, we must clearly signpost it.

## So what's the plan?

Honestly, I have no idea how to even get started. I have never written an SDK before and I've barely used the `@atproto/api` one given by Bluesky.

I would assume that it would need to be tailored to my needs wherever they appear when making other Gleam projects that do ATProto stuff.

Specifically, I have three Gleam/ATProto projects in mind.

- Rizzabel, a bluesky bot that posts [@isabelroses](https://github.com/isabelroses)'s quotes from our Discord server onto bluesky.
- Flopper, a service that automatically scans your posts in the last 72 hours and replies to all of them with [the text in this post](https://bsky.app/profile/pfrazee.com/post/3lximmz7wms2o).
- Isabel's PDS implementation (because she's clinically insane).

Additionally, as a convenience method to people who want to also implement their own SDKs, the library will provide a did:plc

### Current priorities

I will put this upfront: OAuth will remain at the bottom of the priority list until time comes when it stabilises and my understanding of it becomes more sane.

Right now, the priority would be to ensure that both Flopper and Rizzabel can be built. This means that the http client is the top priority and it needs to be able to support both authenticated and unauthenticated requests. Basically, a wrapper around the bluesky API to begin with.

Afterwards, we'll need to add session management and authentications through JWTs (i think). Then we can start thinking about lexicon support.

All other features follow suit as and when the needs arise. Failing that, [we refer to this discussion](https://github.com/bluesky-social/atproto/discussions/2415).

## Example code

This section exists because I think that ergonomics is something that we need to consider early on as well. Downstream consumers must be able to use existing and expected patterns when building their own apps.

A more complete example: (this is absolutely not valid gleam code)

```gleam
// repeat_recent_post.gleam
import akivili/client.{new_client, new_session, CredentialSessionOpts}
import akivili/lexicon

let identifier = "sylfr.dev"
let service_url = "pds.sylfr.dev"
let app_password = "abcd-1234-wxyz-5678"

pub fn main() {
  let assert OK(session) =
    new_session()
    |> client.with_session_opts(CredentialSessionOpts(service_url))

  let assert Ok(authenticated_client) =
    new_client()
    |> client.with_session(session)
    |> client.with_credentials(identifier, app_password)
    |> client.login()

  let repo_records = authenticated_client.list_records(lexicon.app.bsky.feed.post)
  let most_recent_post = authenticated_client.get_record(repo_records).first

  echo most_recent_post.text // console logs the text on the most recent post.

  let new_post = client.BskyPostOpts(text: "My most recent post contained the following text: " <> most_recent_post.text)

  post_res = authenticated_client.post(new_post)

  case post_res {
    Ok(_) -> {
      // do something with the Ok
    }
    Error(_) -> {
      // handle the error appropriately
    }
  }
}

```
