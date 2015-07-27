import sys
from struct import unpack


BYTE_NBIT = 8
INST_NBYTE = 4
INST_UNKNOWN = 'unknown'
INST_MASK = 'x'
INST_MAP = ((31, 26), {
    '000000': ((5, 0), {
        '000000': ('SLL', ['00000', 5, 5, 5]),
        '000010': ('SRL', ['00000', 5, 5, 5]),
        '000011': ('SRA', ['00000', 5, 5, 5]),
        '000100': ('SLLV', [5, 5, 5, '00000']),
        '000110': ('SRLV', [5, 5, 5, '00000']),
        '000111': ('SRAV', [5, 5, 5, '00000']),
        '001000': ('JR', [5, '000000000000000']),
        '001001': ('JALR', [5, '00000', 5, '00000']),
        '001100': ('SYSCALL', ['00000000000000000000']),
        '010000': ('MFHI', ['0000000000', 5, '00000']),
        '010001': ('MTHI', [5, '000000000000000']),
        '010010': ('MFLO', ['0000000000', 5, '00000']),
        '010011': ('MTLO', [5, '000000000000000']),
        '011000': ('MULT', [5, 5, '0000000000']),
        # '011010': ('DIV', [5, 5, '0000000000']),
        '100001': ('ADDU', [5, 5, 5, '00000']),
        '100011': ('SUB', [5, 5, 5, '00000']),
        '100100': ('AND', [5, 5, 5, '00000']),
        '100101': ('OR', [5, 5, 5, '00000']),
        '100110': ('XOR', [5, 5, 5, '00000']),
        '100111': ('NOR', [5, 5, 5, '00000']),
        '101010': ('SLT', [5, 5, 5, '00000']),
        '101011': ('SLTU', [5, 5, 5, '00000']),
        }),
    '000001': ((20, 16), {
        '00000': ('BLTZ', [5, 16]),
        '00001': ('BGEZ', [5, 16]),
        }),
    '000010': ('J', [26]),
    '000011': ('JAL', [26]),
    '000100': ('BEQ', [5, 5, 16]),
    '000101': ('BNE', [5, 5, 16]),
    '000110': ('BLEZ', [5, '00000', 16]),
    '000111': ('BGTZ', [5, '00000', 16]),
    '001001': ('ADDIU', [5, 5, 16]),
    '001010': ('SLTI', [5, 5, 16]),
    '001011': ('SLTIU', [5, 5, 16]),
    '001100': ('ANDI', [5, 5, 16]),
    '001101': ('ORI', [5, 5, 16]),
    '001110': ('XORI', [5, 5, 16]),
    '001111': ('LUI', ['00000', 5, 16]),
    '010000': ((25, 21), {
        '00000': ('MFC0', [5, 5, '00000000000']),
        '00100': ('MTC0', [5, 5, '00000000000']),
        '10000': ((5, 0), {
            '000001': ('TLBR', ['000000000000000']),
            '000010': ('TLBWI', ['000000000000000']),
            '011000': ('ERET', ['000000000000000']),
            }),
        }),
    '100000': ('LB', [5, 5, 16]),
    '100011': ('LW', [5, 5, 16]),
    '100100': ('LBU', [5, 5, 16]),
    '100101': ('LHU', [5, 5, 16]),
    '101000': ('SB', [5, 5, 16]),
    '101011': ('SW', [5, 5, 16]),
    '101111': ('CACHE', [5, 5, 16]),
    })
REG_MAP = (
    ['zero', 'at'] +
    ['v'+str(i) for i in range(2)] +
    ['a'+str(i) for i in range(4)] +
    ['t'+str(i) for i in range(8)] +
    ['s'+str(i) for i in range(8)] +
    ['t'+str(i) for i in range(8, 10)] +
    ['k'+str(i) for i in range(2)] +
    ['gp', 'sp', 'fp', 'ra']
    )


def parse(inst, node):
    part, m = node
    if isinstance(m, dict):
        l, r = part
        part = inst[31-l : 31-r+1]
        if part not in m:
            return INST_UNKNOWN
        return parse(inst[:31-l]+INST_MASK*(l-r+1)+inst[31-r+1:], m[part])
    else:
        res = part
        i = 0
        while i < len(inst) and inst[i] == INST_MASK:
            i += 1
        for p in m:
            if isinstance(p, int):
                pp = inst[i:i+p]
                if p == 5:
                    pp = REG_MAP[int(pp, 2)]
                else:
                    pp = str(int(pp, 2))
                res += ' ' + pp
                i += p
            else:
                pp = inst[i:i+len(p)]
                if pp != p:
                    return INST_UNKNOWN
                i += len(p)
            while i < len(inst) and inst[i] == INST_MASK:
                i += 1
        return res


def main():
    ok = True
    pc = 0
    with open(sys.argv[1], 'rb') as f:
        while True:
            inst = f.read(INST_NBYTE)
            if len(inst) < INST_NBYTE:
                break
            print hex(pc),
            inst = bin(unpack('<I', inst)[0])[2:].zfill(32)
            res = parse(inst, INST_MAP)
            if res == INST_UNKNOWN:
                ok = False
                print 'unknown:', inst, hex(int(inst, 2))
            else:
                print res
            pc += 4
    if not ok:
        print >> sys.stderr, 'RI may happen!'


if __name__ == '__main__':
    main()
