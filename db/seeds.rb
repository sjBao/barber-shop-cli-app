Barber.destroy_all
Client.destroy_all

[
  { name: "Karho" },
  { name: "Tim" },
  { name: "Kevin" },
  { name: "Michael" }
].each { |barber_hash| Barber.create(barber_hash) }