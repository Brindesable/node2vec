INPUT=karate.edgelist
FORMAT=edgelist # const
OUTPUT=karate.ebd
NB_WALKS=10
REP_SIZE=64
WINDOW_SIZE=10
WALK_LENGTH=80
UNDIRECTED=True # const
WORKERS=1

DATE=`date '+%d-%m-%Y_%H-%M-%S'` && \
mkdir -p share/$DATE && \
docker run -v `pwd`/share:/usr/share node2vec:latest \
python /usr/node2vec/src/main.py \
--num-walks $NB_WALKS \
--dimensions $REP_SIZE \
--window-size $WINDOW_SIZE \
--walk-length $WALK_LENGTH \
--workers $WORKERS \
--input /usr/share/$INPUT \
--output /usr/share/$DATE/$OUTPUT > share/$DATE/stdout 2> share/$DATE/stderr && \
PARAMETERS="NB_WALKS=$NB_WALKS
REP_SIZE=$REP_SIZE
WINDOW_SIZE=$WINDOW_SIZE
WALK_LENGTH=$WALK_LENGTH
UNDIRECTED=$UNDIRECTED
WORKERS=$WORKERS" && \
echo $PARAMETERS > share/$DATE/parameters && \
DW_STDOUT=`cat share/$DATE/stdout` && \
DW_STDERR=`cat share/$DATE/stderr` && \
curl -s --user 'api:key-xxx' \
    https://api.mailgun.net/v3/xxx.mailgun.org/messages \
    -F from='Mailgun Sandbox <postmaster@xxx.mailgun.org>' \
    -F to='Kilian Ollivier <xxx@xxx.com>' \
    -F subject='node2vec' \
    -F text="The computation of $OUTPUT just ended.

directory :
$DATE

parameters :
$PARAMETERS

stdout :
$DW_STDOUT

stderr :
$DW_STDERR"
