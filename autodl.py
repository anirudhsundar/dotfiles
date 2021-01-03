import os, sys                                                                                                                                                               import json
import subprocess

def print_error_valid(msg):
    print("ERROR: Please provide a valid {0}".format(msg))
    exit(2)

def get_url(user, repo, file_pattern, remove_v=False):
    if not user:
        print_error_valid("user")
    if not repo:
        print_error_valid("repo")
    if not file_pattern:
        print_error_valid("file_pattern")

    result_str = ''
    if sys.version_info.major == 3:
        result = subprocess.check_output(["curl", "https://api.github.com/repos/{0}/{1}/releases/latest".format(user, repo)])
        result_str = result.decode('utf-8')
    elif sys.version_info.major == 2:
        result = subprocess.check_output(["curl", "https://api.github.com/repos/{0}/{1}/releases/latest".format(user, repo)])
        result_str = result

    if not result:
        print("ERROR: couldn't access api. please check the url...")
        exit(2)
    # result_str = result.stdout.decode('utf-8')
    val = json.loads(result_str)
    if not val:
        print("ERROR: tag_name not found in repo. please check the url...")
        exit(2)

    tag_name = val["tag_name"]
    file_tag = tag_name
    if remove_v:
        file_tag = tag_name.replace('v', '')
    file_pattern = file_pattern.replace("###", file_tag)
    download_url = "https://github.com/{0}/{1}/releases/download/{2}/{3}".format(user, repo, tag_name, file_pattern)
    return download_url

def main():
    tool_config = json.load(open('repo_names.json', 'r'))
    for tool in tool_config:
        user = tool['user']
        repo = tool['repo']
        file_pattern = tool['file_pattern']
        remove_v = False
        if "remove_v" in tool:
            remove_v = True

        url = get_url(user, repo, file_pattern, remove_v=remove_v)
        subprocess.check_output(["wget", url])

if __name__ == '__main__':
    main()
