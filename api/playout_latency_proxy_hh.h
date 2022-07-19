mgr --->   


------------------------------------------------------------
BEGIN_PROXY_MAP(PlayoutLatency)
PROXY_SIGNALING_THREAD_DESTRUCTOR()
PROXY_METHOD2(void, OnStart, cricket::Delayable*, uint32_t)
PROXY_METHOD0(void, OnStop)
PROXY_WORKER_METHOD1(void, SetLatency, double)
PROXY_WORKER_CONSTMETHOD0(double, GetLatency)
END_PROXY_MAP()
-------------------------------------------------------------

  template <class INTERNAL_CLASS>                         
  class PlayoutLatencyProxyWithInternal;                             
  typedef PlayoutLatencyProxyWithInternal<PlayoutLatencyInterface> PlayoutLatencyProxy;    
  template <class INTERNAL_CLASS>                         
  class PlayoutLatencyProxyWithInternal : public PlayoutLatencyInterface {      
   protected:                                             
    typedef PlayoutLatencyInterface C;                               
                                                          
   public:                                                
    const INTERNAL_CLASS* internal() const { return c_; } 
    INTERNAL_CLASS* internal() { return c_; }
 protected:                                                           
  PlayoutLatencyProxyWithInternal(rtc::Thread* signaling_thread,                 
                       rtc::Thread* worker_thread, INTERNAL_CLASS* c) 
      : signaling_thread_(signaling_thread),                          
        worker_thread_(worker_thread),                                
        c_(c) {}                                                      
                                                                      
 private:                                                             
  mutable rtc::Thread* signaling_thread_;                             
  mutable rtc::Thread* worker_thread_;
   protected:                                            
  ~PlayoutLatencyProxyWithInternal() {                            
    MethodCall0<PlayoutLatencyProxyWithInternal, void> call(      
        this, &PlayoutLatencyProxyWithInternal::DestroyInternal); 
    call.Marshal(RTC_FROM_HERE, destructor_thread());  
  }                                                    
                                                       
 private:                                              
  void DestroyInternal() { c_ = nullptr; }             
  rtc::scoped_refptr<INTERNAL_CLASS> c_;
   public:                                                                      
  static rtc::scoped_refptr<PlayoutLatencyProxyWithInternal> Create(                     
      rtc::Thread* signaling_thread, rtc::Thread* worker_thread,              
      INTERNAL_CLASS* c) {                                                    
    return new rtc::RefCountedObject<PlayoutLatencyProxyWithInternal>(signaling_thread,  
                                                           worker_thread, c); 
  }
  
   private:                                                              
  rtc::Thread* destructor_thread() const { return signaling_thread_; } 
                                                                       
 public:  // NOLINTNEXTLINE//void, OnStart, cricket::Delayable*, uint32_t
    void OnStart(cricket::Delayable* a1, uint32_t a2) override {                               
    MethodCall2<C, void, cricket::Delayable*, uint32_t> call(c_, &C::OnStart, std::move(a1), 
                                   std::move(a2));                
    return call.Marshal(RTC_FROM_HERE, signaling_thread_);        
  }
    void OnStop() override {                                    
    MethodCall0<C, void> call(c_, &C::OnStop);                
    return call.Marshal(RTC_FROM_HERE, signaling_thread_); 
  }
  
  void SetLatency(double a1) override {                                   
    MethodCall1<C, void, double> call(c_, &C::SetLatency, std::move(a1)); 
    return call.Marshal(RTC_FROM_HERE, worker_thread_);        
  }
  void GetLatency() const override {                           
    ConstMethodCall0<C, void> call(c_, &C::GetLatency);        
    return call.Marshal(RTC_FROM_HERE, worker_thread_); 
  }
  };