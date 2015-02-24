namespace py skywalker


struct Provider {
  1: required string uuid;
  2: optional string name;
  3: optional string hash;
  4: required Options options;
  5: optional i32 time;
}


struct Identity {
  1: required string uuid;
  2: optional string name;
  3: optional string hash;
  4: required Options options;
  5: optional i32 time;
}


typedef map<string, string> Options;


struct Instance {
  1: required string uuid;
  2: required string machine_uuid;
  3: optional string name;
  4: optional list<string> public_addresses;
  5: optional list<string> private_addresses;
  6: optional string extra;
  7: optional string project_id;
  8: required string provider_hash;
  9: optional string identity_hash;
  10: required i32 time;
}


struct Instances {
  1: required list<Instance> instances;
  2: required string provider_hash;
  3: optional string identity_hash;
  4: required i32 time;
}


exception OpenStackException {
  1: required string message;
}


exception ConnectionException {
  1: required string message;
}


exception DeployException {
  1: required string message;
}


service Skywalker {
  string get_provider_hash(1: Provider provider);

  string get_identity_hash(1: Identity identity);

  Instance get_instance(1: string provider_hash, 2: string identity_hash, 3: string instance_uuid);

  Instances list_instances(
    1: string provider_hash,
    2: string identity_hash)
    throws (1: OpenStackException oex,
            2: ConnectionException cex);

  Instance create_instance(1: string provider_hash, 2: string identity_hash, 3: Options options);

  bool deploy_to_instance(1: string provider_hash, 2: string identity_hash, 3: Options options)
    throws (1: OpenStackException oex,
            2: ConnectionException cex,
            3: DeployException dex);

  void destroy_instance(
    1: string provider_hash,
    2: string identity_hash,
    3: string instance_uuid)
    throws (1: OpenStackException oex,
            2: ConnectionException cex);
}
