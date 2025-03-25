import shutil
import subprocess

with open('../instances_3.csv', 'r') as inst:
    root = '../../../pyrat'
    result_file = f'{root}/OUT/default/analysis_result.txt'
    verified = []
    unsafe = []

    for line in inst:
        f_net, f_prop, timeout = line.strip('\n').split(',')

        subprocess.run(['python', f'{root}/pyrat.pyc', '--model_path', f'../{f_net}', '--property_path', f'../{f_prop}',
                        '--split', 'True', '--verbose', 'True', '--nb_process', '16', '--domains', 'zonotopes',
                        '--timeout', timeout, '--log_dir', 'OUT'])

        safe = False
        with open(result_file, 'r') as result:
            for l in result:
                if 'Result =' in l:
                    safe = l == 'Result = True\n'
                    break

        shutil.rmtree(f'{root}/OUT')
        if safe:
            verified.append(f_prop)
        else:
            unsafe.append(f_prop)

    print(f'# verified: {len(verified)}')
    print(f'# unsafe  : {len(unsafe)}')
