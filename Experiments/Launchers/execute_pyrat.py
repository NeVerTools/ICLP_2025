import shutil
import subprocess
import sys

inst_f = sys.argv[1]

with open(f'{inst_f}', 'r') as inst:
    root = '../../../pyrat'
    result_file = f'{root}/OUT/default/analysis_result.txt'
    verified = []
    unsafe = []
    timeout = []

    for line in inst:
        f_net, f_prop, t = line.strip('\n').split(',')

        subprocess.run(['python', f'{root}/pyrat.pyc', '--model_path', f'../{f_net}', '--property_path', f'../{f_prop}',
                        '--split', 'True', '--verbose', 'True', '--nb_process', '16', '--domains', 'zonotopes',
                        '--timeout', t, '--log_dir', 'OUT'])

        safe = False
        tout = False
        with open(result_file, 'r') as result:
            for l in result:
                if 'Result =' in l:
                    safe = l == 'Result = True\n'
                    tout = 'Timeout' in l
                    break

        shutil.rmtree(f'{root}/OUT')
        if safe:
            verified.append(f_prop)
        else:
            if tout:
                timeout.append(f_prop)
            else:
                unsafe.append(f_prop)

print(f'Verified : {len(verified)}')
print(f'Unsafe   : {len(unsafe)}')
print(f'Timeout  : {len(timeout)}')
