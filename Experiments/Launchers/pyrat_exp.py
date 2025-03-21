import subprocess

with open('../instances.csv', 'r') as inst:
    root = '../../../pyrat'

    for line in inst:
        f_net, f_prop, timeout = line.strip('\n').split(',')

        subprocess.run(['python', f'{root}/pyrat.pyc', '--model_path', f'../{f_net}', '--property_path', f'../{f_prop}',
                        '--split', 'True', '--verbose', 'True', '--nb_process', '16', '--domains', 'zonotopes',
                        '--timeout', timeout])
