trains = [0.22190540181382196, 1.2598992417206438]
thetas = [0.22190540181382196,
          -2.445329661647363,
          2.3469316292555544,
          0.46587531862791004,
          2.618552423351554,
          -2.2679542943142543,
          0.6858226665030666,
          -0.8861995981514541,
          -0.6609035330567311,
          -0.4977147490473767,
          1.2598992417206438,
          -1.2960608846915842,
          1.0894985364190608,
          1.1272297820406245,
          0.6608630899761982,
          -0.3594689482813536,
          0.4508652937314785,
          0.8324537804952823,
          0.9571060089140446,
          0.10493949838653123]

counts = []

for theta in thetas:
    qc = kariya_circuit(trains, theta)

    simulator = Aer.get_backend('qasm_simulator')
    job = execute(qc, simulator, shots=8192)
    result = job.result().get_counts()
    result = {key[1]: val for key, val in result.items() if key[0] == '0'}
    if result['0'] > result['1']:
        counts.append(0)
    else:
        counts.append(1)

print(counts)
