import sys
from g2p_en import G2p
import re

if __name__ == "__main__":
    g2p = G2p()
    for line in sys.stdin:
        utt_id = line.split()[0]
        text = ' '.join(line.split()[1:])
        arpa = g2p(text)
        
        # Remove stress symbols
        arpa_new = []
        for sym in arpa:
            if len(sym) >= 1 and sym[-1].isdigit():
                arpa_new.append(sym[:-1])
            else:
                arpa_new.append(sym)
        arpa=arpa_new

        # Convert ' ' to <space>
        arpa = ' '.join([_ if _ != ' ' else '<space>' for _ in arpa])
        arpa = re.sub("['.,?!\-]", "", arpa)

        outp = utt_id + ' ' + arpa
        print(outp)