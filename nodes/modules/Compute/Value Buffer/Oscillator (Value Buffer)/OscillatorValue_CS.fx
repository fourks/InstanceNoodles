#include "..\..\..\Common\InstanceNoodles.fxh"

struct Oscillator
{	
float CurrentPos;
float PreviousPos;	
float CurrentVel;
float PreviousVel;	
};

StructuredBuffer<float> GoalPosBuffer, EnergyBuffer, DampingBuffer, DTBuffer;


float DefaultEnergy = 0.3;
float DefaultDamping = 0.8;
float DefaultDt=.1;


RWStructuredBuffer<Oscillator> Output : BACKBUFFER;

[numthreads(128, 1, 1)]
void CSpos( uint3 i : SV_DispatchThreadID)
{ 
	if (i.x > threadCount) { return; }
	
	float GoalPos = bLoad(GoalPosBuffer, 0, i.x);
	float energy = bLoad(EnergyBuffer, DefaultEnergy, i.x);
	float damping = bLoad(DampingBuffer, DefaultDamping, i.x);
	float dT = bLoad(DTBuffer, DefaultDt, i.x);
	
	float acc = energy * (GoalPos - Output[i.x].PreviousPos) - (2 * damping  * Output[i.x].PreviousVel);
	
	Output[i.x].CurrentVel = Output[i.x].PreviousVel + acc * dT;
	Output[i.x].CurrentPos = Output[i.x].PreviousPos + (Output[i.x].PreviousVel + 0.5 * acc * dT) * dT;
	

	
	//AutoFeed for getting FrameDiff	
	Output[i.x].PreviousPos = Output[i.x].CurrentPos;
	Output[i.x].PreviousVel =  Output[i.x].CurrentVel;	
}




technique11 Oscillator3D
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CSpos() ) );
	}
}






