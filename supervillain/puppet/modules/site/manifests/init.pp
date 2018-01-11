class site::init{
    # configures actions for first and last stages
    class{'site::yum': stage => first }
    class{'site::configuration': stage => last }
}
