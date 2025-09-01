import akivili/client

pub fn main() -> Nil {
  let app_client = client.new_client() |> client.with_session("pds.tgirl.cloud")

  let assert Ok(records) = client.list_records(app_client)

  echo records

  Nil
}
