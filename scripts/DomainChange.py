__author__ = 'root'
import subprocess
def readValuesFromFile():
    OLD = dict(line.strip().split('=') for line in open('olddomain.properties') if
             not line.startswith('#') and not line.startswith('\n'))
    NEW = dict(line.strip().split('=') for line in open('domain.properties') if
             not line.startswith('#') and not line.startswith('\n'))
    return OLD,NEW

def replaceDump(path,OLD,NEW):
    for key, value in NEW.items():
        subprocess.call(['sed','-i','s/'+OLD[key]+'/'+NEW[key]+'/g',path])

def deleteLogs():
    subprocess.call("find ../ -type f -name *.log -exec rm -f {} \;", shell=True )

def replaceCrowdPropertyFile():
    subprocess.call("find ../ -type f -name crowd.properties -exec sed -i s/reqlax.com/zptr.com/g {} \;", shell=True )

if __name__ == '__main__':
    print("main code")
    deleteLogs()
    replaceCrowdPropertyFile()
    products=['jira','confluence','bamboo','crucible','crowd']
    for product in products:
        path='../tmp/'+product+'.dump'
        OLD,NEW = readValuesFromFile()
        replaceDump(path,OLD,NEW)