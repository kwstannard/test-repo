module Database
  if Provider.none? || Client.none? # prevent duplication
    notes = [
      "I ate well",
      "I ate poorly",
      "I was mad",
      "I was happy"
    ]

    providers = [
      ['Pete', 'Jones'],
      ['Polly', 'Stevens'],
      ['Percy', 'Jefferson'],
    ].map { Provider.create!(name: _1.join(" "), email: _1.join(".").then{|e| e+'@provider'}.downcase) }

    clients = [
      ['Calvin', 'Coolidge'],
      ['Corey', 'Coose'],
      ['Casey', 'Jones'],
      ['Callie', 'Fergison']
    ].map {
      c = Client.create!(name: _1.join(" "), email: _1.join(".").then{|e| e+'@client'}.downcase)

      (1..3).to_a.sample.times.each do |i|
        journal = c.journals.create(name: "Journal ##{i}")

        3.times.map { notes.sample }.uniq.each do |note|
          journal.notes.create(text: note)
        end
      end
      c
    }

    providers.each do |p|
      p.clients = 3.times.map { clients.sample }.uniq
      p.save!
    end
  end
end
