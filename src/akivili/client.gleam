import gleam/option.{type Option, None, Some}

pub type Agent {
  Agent(service: Option(String))
}

pub fn new_client() -> Agent {
  Agent(None)
}

pub fn with_session(agent: Agent, service: String) -> Agent {
  Agent(..agent, service: Some(service))
}

pub fn login(agent: Agent, identifier: String, password: String) -> Agent {
  todo
  // TODO: actually implement the login
}
