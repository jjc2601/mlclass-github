 return (
    <div className="min-h-screen bg-[#09090b] text-gray-200 font-sans selection:bg-purple-500/30 selection:text-purple-200 relative overflow-x-hidden">
      {/* Background Ambience */}
      <div className="fixed inset-0 z-0 pointer-events-none">
        <div className="absolute top-[-10%] left-[-10%] w-[40%] h-[40%] bg-purple-900/20 rounded-full blur-[120px]" />
        <div className="absolute bottom-[-10%] right-[-10%] w-[40%] h-[40%] bg-blue-900/10 rounded-full blur-[120px]" />
        <div className="absolute top-[20%] right-[20%] w-[20%] h-[20%] bg-indigo-500/10 rounded-full blur-[80px]" />
        <div 
          className="absolute inset-0 opacity-10"
          style={{
            backgroundImage: `url("https://images.unsplash.com/photo-1550729154-e3abdffadd93?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=1920")`,
            backgroundSize: 'cover',
            backgroundPosition: 'center',
            backgroundBlendMode: 'overlay'
          }}
        />
        <div className="absolute inset-0 bg-gradient-to-b from-[#09090b]/80 via-[#09090b]/50 to-[#09090b]" />
      </div>

      <div className="relative z-10 max-w-7xl mx-auto px-4 py-8 md:py-12">
        
        {/* Header */}
        <motion.header 
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6 }}
          className="text-center mb-12 md:mb-16"
        >
          <div className="flex items-center justify-center gap-3 mb-4 text-purple-400">
            <Moon className="w-6 h-6" />
            <Sparkles className="w-5 h-5 opacity-75" />
          </div>
          <h1 className="text-4xl md:text-6xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-gray-100 via-purple-200 to-gray-400 mb-2 tracking-tight">
            Penguin Weight Predictor
          </h1>
          <p className="text-gray-400 text-lg md:text-xl font-light tracking-wide flex items-center justify-center gap-2">
            <Activity className="w-4 h-4 text-purple-500" />
            Machine Learning Prediction Interface
          </p>
        </motion.header>

        <div className="grid grid-cols-1 lg:grid-cols-12 gap-8">
          
          {/* Main Prediction Column */}
          <div className="lg:col-span-7 space-y-8">
            <Card title="Model Input Parameters" className="border-t-4 border-t-purple-600">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                
                {/* Categorical Inputs */}
                <div className="space-y-1">
                  <h4 className="text-xs font-bold text-purple-400 uppercase tracking-widest mb-4 flex items-center gap-2">
                    <Database className="w-3 h-3" /> Categorical Data
                  </h4>
<Select label="Species" value={species} onChange={(e) => setSpecies(e.target.value)} />
<Select label="Island" value={island} onChange={(e) => setIsland(e.target.value)} />
<Select label="Sex" value={sex} onChange={(e) => setSex(e.target.value)} />
                </div>

                {/* Numeric Inputs */}
                <div className="space-y-1">
                  <h4 className="text-xs font-bold text-purple-400 uppercase tracking-widest mb-4 flex items-center gap-2">
                    <Binary className="w-3 h-3" /> Numerical Data
                  </h4>
                  <Input
                    label="Culmen Length (mm)"
                    type="number"
                    value={culmenLength}
                    onChange={(e) => setCulmenLength(e.target.value)}
                  />

                  <Input
                    label="Culmen Depth (mm)"
                    type="number"
                    value={culmenDepth}
                    onChange={(e) => setCulmenDepth(e.target.value)}
                  />

                  <Input
                    label="Flipper Length (mm)"
                    type="number"
                    value={flipperLength}
                    onChange={(e) => setFlipperLength(e.target.value)}
                  />

                  <Input
                    label="Body Mass (g)"
                    type="number"
                    value={bodyMass}
                    onChange={(e) => setBodyMass(e.target.value)}
                  />
                </div>
              </div>

              <div className="mt-8 pt-6 border-t border-white/5">
                <Button onClick={requestAPI} isLoading={loading}>
                  <Zap className="w-4 h-4" />
                  Run Prediction Model
                </Button>
              </div>

              {/* Result Display */}
              <AnimatePresence>
                {prediction && (
                  <motion.div
                    initial={{ opacity: 0, height: 0, marginTop: 0 }}
                    animate={{ opacity: 1, height: 'auto', marginTop: 24 }}
                    exit={{ opacity: 0, height: 0, marginTop: 0 }}
                    className="overflow-hidden"
                  >
                    <div className="bg-purple-900/20 border border-purple-500/30 rounded-lg p-6 flex flex-col items-center justify-center text-center relative">
                      <div className="absolute top-0 left-0 w-full h-full overflow-hidden rounded-lg">
                        <div className="absolute top-[-50%] left-[-50%] w-[200%] h-[200%] bg-[radial-gradient(circle_at_center,_var(--tw-gradient-stops))] from-purple-500/10 via-transparent to-transparent animate-spin-slow" />
                      </div>
                      <span className="text-purple-300 text-sm font-medium uppercase tracking-widest mb-2 relative z-10">Analysis Complete</span>
                      <h2 className="text-4xl md:text-5xl font-bold text-white mb-2 relative z-10 shadow-purple-500/50 drop-shadow-[0_0_10px_rgba(168,85,247,0.5)]">
                        {prediction.label}
                      </h2>
                      <div className="flex items-center gap-2 text-gray-400 text-sm relative z-10">
                        <Brain className="w-4 h-4" />
                        <span>Confidence Level: <span className="text-purple-400 font-bold">{prediction.confidence}%</span></span>
                      </div>
                    </div>
                  </motion.div>
                )}
              </AnimatePresence>
            </Card>
          </div>

          {/* Info Column */}
          <div className="lg:col-span-5 space-y-6">
            
            {/* About Me */}
            <Card className="flex flex-col md:flex-row gap-6 items-center md:items-start">
              <div className="shrink-0 relative">
                <div className="w-20 h-20 rounded-full overflow-hidden border-2 border-purple-500/50 shadow-[0_0_15px_rgba(168,85,247,0.3)]">
                  <img 
                    src="https://images.unsplash.com/photo-1649451844813-3130d6f42f8a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=200" 
                    alt="Developer" 
                    className="w-full h-full object-cover"
                  />
                </div>
                <div className="absolute bottom-0 right-0 w-6 h-6 bg-[#09090b] rounded-full flex items-center justify-center border border-purple-500/50">
                   <Code className="w-3 h-3 text-purple-400" />
                </div>
              </div>
              <div>
                <h3 className="text-xl font-bold text-gray-100 mb-2">About the Developer</h3>
                <p className="text-gray-400 text-sm leading-relaxed">
                  I'm a CS student passionate about bridging the gap between raw data and actionable insights. This project demonstrates my ability to build intuitive interfaces for complex machine learning models.
                </p>
              </div>
            </Card>

            {/* How It Works */}
            <Card title="How This Model Works">
              <div className="relative pl-6 border-l border-purple-500/20 space-y-8 my-4">
                
                {/* Step 1 */}
                <div className="relative">
                  <div className="absolute -left-[31px] top-0 w-4 h-4 rounded-full bg-[#09090b] border-2 border-purple-500 flex items-center justify-center">
                    <div className="w-1.5 h-1.5 rounded-full bg-purple-500" />
                  </div>
                  <h4 className="text-gray-200 font-medium mb-1 flex items-center gap-2">
                    <Database className="w-4 h-4 text-gray-500" /> Data Ingestion
                  </h4>
                  <p className="text-gray-500 text-sm">
                    Raw penguin measurements (mass, dimensions) and categorical data (island, sex) are collected via the input form.
                  </p>
                </div>

                {/* Step 2 */}
                <div className="relative">
                  <div className="absolute -left-[31px] top-0 w-4 h-4 rounded-full bg-[#09090b] border-2 border-purple-500/50 flex items-center justify-center">
                     <div className="w-1.5 h-1.5 rounded-full bg-purple-500/50" />
                  </div>
                  <h4 className="text-gray-200 font-medium mb-1 flex items-center gap-2">
                    <Cpu className="w-4 h-4 text-gray-500" /> Encoding & Processing
                  </h4>
                  <p className="text-gray-500 text-sm">
                    Categorical inputs are one-hot encoded. Numerical inputs are normalized to match the training distribution.
                  </p>
                </div>

                {/* Step 3 */}
                <div className="relative">
                  <div className="absolute -left-[31px] top-0 w-4 h-4 rounded-full bg-[#09090b] border-2 border-purple-500/30 flex items-center justify-center">
                     <div className="w-1.5 h-1.5 rounded-full bg-purple-500/30" />
                  </div>
                  <h4 className="text-gray-200 font-medium mb-1 flex items-center gap-2">
                    <Brain className="w-4 h-4 text-gray-500" /> Inference
                  </h4>
                  <p className="text-gray-500 text-sm">
                    The pre-trained Random Forest model analyzes the feature vector to generate a probabilistic prediction, not simple memorization.
                  </p>
                </div>

              </div>
              
              <div className="mt-6 bg-purple-900/10 rounded-lg p-3 border border-purple-500/10 flex items-center justify-center gap-4 text-xs text-purple-300">
                <div className="flex flex-col items-center">
                   <span className="font-bold text-lg">344</span>
                   <span className="opacity-70">Training Samples</span>
                </div>
                <div className="h-8 w-px bg-purple-500/20" />
                <div className="flex flex-col items-center">
                   <span className="font-bold text-lg">98.5%</span>
                   <span className="opacity-70">Accuracy</span>
                </div>
              </div>

            </Card>

          </div>
        </div>
      </div>
    </div>
  );
}