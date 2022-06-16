# This node listens to the contact sensor from gazebo and checks to see if a collision has occured.
# The purpose of this script is to cache the fact that a collision may occur while executing a point to point (PTP)
# command. This is because as we move from point A , and point B, the endpoints may not have a collision, but the 
# path to the end points may have a collision, which is still unacceptable.
# The node listens on /collisionTopic <-- contact sensor from gazebo publishes to it
# The node listens on /resetCollisionFlag <-- Matlab publishes to this topic when it has processed the validity of a PTP command
# The node publishes on /collisionFlag --> Matlab reads this flag to check if a collision occured command

import rospy
from std_msgs.msg import Bool
from gazebo_msgs.msg import ContactsState

class collisionHandlerNode():
  
  def __init__(self):
    self.collFlag = 0
    rospy.init_node('collisionHandlerNode')
    # print("entering constructor")

    self.pub = rospy.Publisher('collisionFlag', Bool, queue_size=10)
    # print("creating a collisionFlagPublisher")

    subCollTL = rospy.Subscriber("collisionTopicToolLink", ContactsState, self.callbackRaiseCollisionFlag)
    # print("creating collisionTopic subscriber")

    subCollWp = rospy.Subscriber("collisionTopicWorkpeice", ContactsState, self.callbackRaiseCollisionFlag)
    # print("creating collisionTopic subscriber")

    subCollL6 = rospy.Subscriber("collisionTopicLink6", ContactsState, self.callbackRaiseCollisionFlag)
    # print("creating collisionTopic subscriber")

    subCollL7 = rospy.Subscriber("collisionTopicLink7", ContactsState, self.callbackRaiseCollisionFlag)
    # print("creating collisionTopic subscriber")

    subResetColl = rospy.Subscriber("resetCollisionFlag", Bool, self.callbackReset)
    # print("creating collisionTopic subscriber")

    self.timer = rospy.Timer(rospy.Duration(secs=0.01), self.timer_callback)
    # print("timer called")

  def timer_callback(self, timer):
    # print("entering timer callback")
    # rospy.loginfo("collFlag =  {}".format(self.collFlag))
    self.pub.publish(self.collFlag)

  def callbackRaiseCollisionFlag(self,data):
    # print("entering collision ")
    # if self.collFlag == 0:
        
    if len(data.states)!=0:
        self.collFlag = 1
        print("new collision, raising collision flag")
    
        # rospy.loginfo(len(data.states)==0)
        # type(data)
        
    
  def callbackReset(self,data):
    print("resetting collision flag")
    # rospy.loginfo("collFlag =  {}".format(self.collFlag))
    self.collFlag = 0

if __name__ == '__main__':

  print("entering main")
  
  try:
    collisionHandlerNode()
    print("entering Try")
    rospy.spin()
  except rospy.ROSInterruptException:
    print("exception thrown")
    pass