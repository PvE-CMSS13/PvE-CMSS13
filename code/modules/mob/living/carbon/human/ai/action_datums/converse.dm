/datum/ai_action/converse
	name = "Start Conversation"
	action_flags = ACTION_USING_MOUTH

/datum/ai_action/converse/get_weight(datum/human_ai_brain/brain)
	if(!COOLDOWN_FINISHED(brain, conversation_start_cooldown))
		return 0

	COOLDOWN_START(brain, conversation_start_cooldown, 1 SECONDS)

	if(brain.in_combat || brain.in_conversation || (brain.tied_human.health < HEALTH_THRESHOLD_CRIT))
		return 0

	if(!prob(brain.conversation_start_prob))
		return 0

	return ACTION_WEIGHT_CONVERSE

/datum/ai_action/converse/trigger_action()
	. = ..()
	if(.)
		return .

	var/list/ai_nearby = list()
	for(var/mob/living/carbon/human/nearby_human in view(2, brain.tied_human))
		var/datum/human_ai_brain/other_brain = nearby_human.get_ai_brain()
		if(!other_brain || other_brain.in_combat || other_brain.in_conversation || other_brain.tied_human.client || (other_brain.tied_human.health < HEALTH_THRESHOLD_CRIT))
			continue

		ai_nearby += other_brain

	if(length(ai_nearby) <= 1)
		return ONGOING_ACTION_COMPLETED

	var/datum/human_ai_conversation/picked_convo
	var/picked_index

	for(var/i = length(GLOB.human_ai_conversations), i > 1, i--)
		var/list/viable_conversations = list()
		for(var/datum/human_ai_conversation/convo as anything in GLOB.human_ai_conversations[i])
			if(!convo.conversation_allowed(brain))
				continue
			viable_conversations += convo

		if(!length(viable_conversations))
			continue

		picked_index = i
		picked_convo = pick(viable_conversations)

	if(length(ai_nearby) > picked_index)
		var/list/cut_down_ai_nearby = list()
		for(var/i in 1 to picked_index)
			cut_down_ai_nearby += pick_n_take(ai_nearby)
		ai_nearby = cut_down_ai_nearby

	var/datum/human_ai_conversation/gotten_convo = picked_convo
	INVOKE_ASYNC(gotten_convo, TYPE_PROC_REF(/datum/human_ai_conversation, initiate_conversation), ai_nearby)
	return ONGOING_ACTION_COMPLETED

